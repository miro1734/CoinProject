package org.coin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.server.ServerEndpoint;

import org.coin.dto.BoardDTO;
import org.coin.dto.CommentDTO;
import org.coin.dto.MemberDTO;
import org.coin.dto.NewsDTO;
import org.coin.dto.PaggingVO;
import org.coin.service.BoardService;
import org.coin.service.CommentService;
import org.coin.service.MemberService;
import org.coin.service.NewsService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MainController {
	private NewsService newsService;
	private MemberService memberService;
	private BoardService boardService;
	private CommentService commentService;

	public MainController(NewsService newsService, MemberService memberService, BoardService boardService,
			CommentService commentService) {
		this.newsService = newsService;
		this.memberService = memberService;
		this.boardService = boardService;
		this.commentService = commentService;
	}

	@RequestMapping("/")
	public String index() {
		return "index";
	}
	@RequestMapping("login.do") // 메인 페이지로 이동하면서 뉴스 게시판 내용 불러오는 부분 - 김경환
	public String main(HttpServletRequest request, HttpSession session) {
		String id;
		String passwd;
		if (session.getAttribute("client") == null) {
			id = request.getParameter("userID");
			passwd = request.getParameter("userPassword");
			if(id.equals("admin") && passwd.equals("1234")) {//관리자페이지로 이동 - 김예찬 10/22
				return "redirect:adminSelect.do";
			}
		} else {
			id = ((MemberDTO) session.getAttribute("client")).getId();
			passwd = ((MemberDTO) session.getAttribute("client")).getPasswd();
		}
		MemberDTO dto = memberService.login(id, passwd);
		List<NewsDTO> news = newsService.selectAllNews();
		request.setAttribute("list", news);
		session.setAttribute("client", dto);
		return "main";
	}
	
	@RequestMapping("newsWrite.do") // 관리자 계정으로 뉴스 게시판 글 작성하는 부분, ajax로 jsonArray 리턴 - 김경환
	public String newsWrite(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8;");
		String headline = request.getParameter("headline");
		int count = newsService.insertNews(headline);
		if (count == 0) {
			response.getWriter().write("<script>alert('등록 실패');history.back()</script>");
		}
		List<NewsDTO> news = newsService.selectAllNews();
		JSONArray arr = new JSONArray(news);
		response.getWriter().write(arr.toString());
		return null;
	}

	@RequestMapping("adminSelect.do") // 가입자 불러오기 - 김예찬 - 10/22
	public String adminSelect(HttpServletRequest request) {
		List<MemberDTO> list = memberService.selectAllMember();
		request.setAttribute("list", list);
		return "admin/adminPage";
	}
	
	@RequestMapping("adminDelete.do") // 가입자 제명 - 김예찬 - 10/22
	public String adminDelete(HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		String id = request.getParameter("id");
		memberService.deleteMember(id);
		List<MemberDTO> list = memberService.selectAllMember();
		request.setAttribute("list", list);
		return "redirect:/adminSelect.do";
	}
	
	@RequestMapping("delete.do") // 관리자 계정으로 뉴스 게시판 글 삭제 - 김경환
	public String newsDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		int nno = Integer.parseInt(request.getParameter("nno"));
		int count = newsService.deleteNews(nno);
		if (count == 0) {
			response.getWriter().write("<script>alert('삭제 실패');history.back()</script>");
		}
		List<NewsDTO> news = newsService.selectAllNews();
		JSONArray arr = new JSONArray(news);
		response.getWriter().write(arr.toString());
		return null;
	}

	@RequestMapping("coinInfo.do") // 코인 이름을 누르면 해당 코인 정보로 이동 - 김경환 // 게시판불러오기 - 김예찬 - 10/16
	public String coinInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		response.setContentType("text/html;charset=utf-8");
		String code = request.getParameter("code");
		String name = request.getParameter("name");
		String id = ((MemberDTO) session.getAttribute("client")).getId();
		String positionMoney = memberService.selectPrice(id, code);
		MemberDTO dtoMember = memberService.selectMember(id);
		List<String> allPositionMoney = memberService.selectPositionMoney(id);
		String positionCount = memberService.selectPositionCount(id, code);
		int APmoney = 0;
		for (int i = 0; i < allPositionMoney.size(); i++)
			APmoney += Integer.parseInt(allPositionMoney.get(i));
		List<String> favoriteCoins = memberService.selectFavoriteCoin(id, code);
		request.setAttribute("favoriteCoins", favoriteCoins);
		request.setAttribute("positionMoney", positionMoney);
		request.setAttribute("allPositionMoney", APmoney);
		request.setAttribute("code", code);
		session.setAttribute("code", code);
		request.setAttribute("name", name);
		request.setAttribute("now_money", dtoMember.getKrw());
		if (positionCount == null) {
			request.setAttribute("positionCount", 0);
		} else {
			request.setAttribute("positionCount", positionCount);
		}
		String pageNo = request.getParameter("pageNo");
		int currentPageNo = pageNo == null || pageNo.equals("") ? 1 : Integer.parseInt(pageNo);
		ArrayList<BoardDTO> list = boardService.selectBoard(currentPageNo, code);
		request.setAttribute("list", list);
		int count = boardService.selectBoardCount();
		PaggingVO vo = new PaggingVO(count, currentPageNo, 5, 4);
		request.setAttribute("pagging", vo);
		return "coin_info";
	}

	@RequestMapping("coinBuy.do") // 코인 매수하는 부분 - 김경환
	public String coinBuy(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		String code = request.getParameter("code");
		String id = request.getParameter("id");
		double count = Double.parseDouble(request.getParameter("count"));
		JSONObject obj = new JSONObject();
		int price = Integer.parseInt(request.getParameter("price"));
		int trade_price = Integer.parseInt(request.getParameter("trade_price"));
		int result;
		List<MemberDTO> list = memberService.selectPosition(code, id);
		if (list.size() == 0) {
			result = memberService.insertPosition(code, id, count, price, trade_price);
		} else {
			result = memberService.updatePositionBuy(code, id, count, price, trade_price);
		}
		if (result == 0) {
			response.getWriter().write("<script>alert('체결 실패');hitory.back();</script>");
		}
		memberService.updatePriceBuy(price, id);
		String dtoPosition = memberService.selectPrice(id, code);
		MemberDTO dtoMember = memberService.selectMember(id);
		obj.put("memberMoney", dtoMember.getKrw());
		obj.put("positionMoney", dtoPosition);
		obj.put("message", "매수 주문이 체결되었습니다.");
		request.setAttribute("now_money", dtoMember.getKrw());
		response.getWriter().write(obj.toString());
		return null;
	}

	@RequestMapping("coinSell.do") // 코인 매도하는 부분 -김경환 10/18
	public String coinSell(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		String code = request.getParameter("code");
		String id = request.getParameter("id");
		double count = Double.parseDouble(request.getParameter("count"));
		int price = Integer.parseInt(request.getParameter("price"));
		List<MemberDTO> list = memberService.selectPosition(code, id);
		int result = memberService.updatePositionSell(code, id, count, price);
		if (result == 0) {
			response.getWriter().write("<script>alert('체결 실패');hitory.back();</script>");
		}
		memberService.updatePriceSell(price, id);
		String dtoPosition = memberService.selectPrice(id, code);
		MemberDTO dtoMember = memberService.selectMember(id);
		JSONObject obj = new JSONObject();
		obj.put("memberMoney", dtoMember.getKrw());
		obj.put("positionMoney", dtoPosition);
		obj.put("message", "매도 주문이 체결되었습니다.");
		response.getWriter().write(obj.toString());
		return null;
	}

	@RequestMapping("refreshPositionCount.do") // 가진 코인 개수 최신화 - 김겨오한
	public String refreshPositionCount(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {
		response.setContentType("text/html;charset=utf-8");
		String id = ((MemberDTO) session.getAttribute("client")).getId();
		int result = memberService.updatePositionCount(id);
		response.getWriter().write("<script>history.back();</script>");
		return null;
	}

	@RequestMapping("insertFavoriteCoin.do") // 관심종목 지정 기능 - 김경환 10/21
	public String insertFavoriteCoin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {
		response.setContentType("text/html;charset=utf-8");
		String id = ((MemberDTO) session.getAttribute("client")).getId();
		String code = ((String) session.getAttribute("code"));
		int result = memberService.insertFavoriteCoin(id, code);
		JSONObject obj = new JSONObject();
		if (result == 0) {
			obj.put("message", "관심코인 등록 실패");
		}
		List<String> favoriteCoins = memberService.selectFavoriteCoin(id, code);
		obj.put("message", "관심종목으로 지정했습니다.");
		obj.put("favoriteCoins", favoriteCoins);
		obj.put("html", "<img src='/resource/img/check_star.png' class='icon_check_star'>");
		response.getWriter().write(obj.toString());
		return null;
	}

	@RequestMapping("deleteFavoriteCoin.do") // 관심 종목 제거 - 김경환
	public String deleteFavoriteCoin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {
		response.setContentType("text/html;charset=utf-8");
		String id = ((MemberDTO) session.getAttribute("client")).getId();
		String code = ((String) session.getAttribute("code"));
		int result = memberService.deleteFavoriteCoin(id, code);
		JSONObject obj = new JSONObject();
		if (result == 0) {
			obj.put("message", "관심코인 삭제 실패");
		}
		List<String> favoriteCoins = memberService.selectFavoriteCoin(id, code);
		obj.put("message", "관심종목을 제거했습니다.");
		obj.put("favoriteCoins", favoriteCoins);
		obj.put("html", "<img src='/resource/img/star.png' class='icon_star'>");
		response.getWriter().write(obj.toString());
		return null;
	}

	@RequestMapping("registerView.do") // 회원가입 페이지로 이동 - 최진욱
	public String main() {
		return "member/join";
	}

	@RequestMapping("register.do") // 회원가입 부분 - 최진욱 10/16
	public String register(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("id");
		String passwd = request.getParameter("pass");
		String name = request.getParameter("name");
		String email = request.getParameter("email");

		MemberDTO dto = new MemberDTO(id, passwd, name, email, 0);
		System.out.println("dto는 : " + dto.toString());
		int count = memberService.insertCoinMember(dto);
		System.out.println(count);
		if (count == 0) {
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write("<script>alert('회원가입에 실패했습니다.');history.back();</script>");
			return null;
		}
		return "index";
	}

	@RequestMapping("idCheck.do")
	public String idCheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("id");
		MemberDTO dto = memberService.idCheck(id);
		JSONObject object = new JSONObject();
		System.out.println(dto);
		if (dto == null)
			object.put("result", true);
		else
			object.put("result", false);
		response.getWriter().write(object.toString());
		return null;
	}

	@RequestMapping("memberUpdateView.do") // 회원수정 페이지 이동 - 최진욱 10/21
	public String memberUpdateView() {
		return "member/member_update";
	}

	@RequestMapping("memberUpdate.do") // 회원수정 페이지 - 최진욱 10/21
	public String memberUpdate(HttpServletRequest request, RedirectAttributes redirectAttributes, HttpSession session)
			throws IOException {
		String id = request.getParameter("id");
		String passwd = request.getParameter("pass");
		String name = request.getParameter("name");
		String email = request.getParameter("email");

		memberService.updateMember(id, passwd, name, email);
		MemberDTO dto = memberService.login(id, passwd);
		session.setAttribute("client", dto);
		return "redirect:login.do?userID=" + dto.getId() + "&userPassword=" + dto.getPasswd();
	}

	@RequestMapping("boardWriteView.do") // 페이지 이동 - 김예찬 10/16
	public String boardWriteView() {
		return "board/board_write";
	}

	@RequestMapping("boardWrite.do") // 게시판 글 작성 - 김예찬 10/18
	public String boardwrite(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String title = request.getParameter("title");
		String bcontent = request.getParameter("bcontent");
		String writer = ((MemberDTO) session.getAttribute("client")).getId();
		String code = (String) session.getAttribute("code");
		int bno = boardService.insertBoard(new BoardDTO(0, title, writer, null, bcontent, 0, 0, 0, code));
		return "redirect:coinInfo.do?code=" + code;
	}

	@RequestMapping("boardView.do") // 게시판 글 보기 페이지로 이동 - 김예찬 10/16
	public String board(HttpServletRequest request) {
		int bno = Integer.parseInt(request.getParameter("bno"));
		boardService.addBoardCount(bno);
		BoardDTO dto = boardService.selectBoardContent(bno);
		request.setAttribute("board", dto);
		ArrayList<CommentDTO> commentList = commentService.selectComment(bno);
		request.setAttribute("commentList", commentList);
		return "board/board_view";
	}

	// 게시글 수정 페이지로 이동 - 김예찬 -10/18
	@RequestMapping("boardUpdateView.do")
	public String boardUpdateView(HttpServletRequest request) {
		int bno = Integer.parseInt(request.getParameter("bno"));
		BoardDTO dto = boardService.selectBoardContent(bno);
		request.setAttribute("board", dto);
		return "board/board_update_view";
	}

	// 게시글 수정 - 김예찬 - 10/18
	@RequestMapping("boardUpdate.do")
	public String boardUpdate(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		String title = request.getParameter("title");
		String bcontent = request.getParameter("bcontent");
		int bno = Integer.parseInt(request.getParameter("bno"));

		boardService.updateBoard(bno, title, bcontent);
		redirectAttributes.addAttribute("bno", bno);
		return "redirect:/boardView.do?bno=" + bno;
	}

	// 게시글 삭제 - 김예찬 10/18
	@RequestMapping("boardDelete.do")
	public String boardDelete(HttpServletRequest request, HttpSession session) {
		int bno = Integer.parseInt(request.getParameter("bno"));
		boardService.deleteBoard(bno);
		String code = (String) session.getAttribute("code");
		return "redirect:coinInfo.do?code=" + code;
	}

	@RequestMapping("insertCcontent.do") // 댓글 작성 - 김예찬 10/18
	public String ccontentwrite(HttpServletRequest request, HttpSession session) {
		String ccontent = request.getParameter("ccontent");
		String cwriter = ((MemberDTO) session.getAttribute("client")).getId();
		int bno = Integer.parseInt(request.getParameter("bno"));

		int cno = commentService.insertCcontent(new CommentDTO(0, ccontent, null, bno, cwriter));
		return "redirect:boardView.do?bno=" + bno;
	}

	@RequestMapping("updateCcontent.do") // 댓글 수정 - 김예찬 10/19
	public String updatecComment(HttpServletRequest request, RedirectAttributes redirectAttributes,
			HttpSession session) {
		String ccontent = request.getParameter("updateCcontent");
		int bno = Integer.parseInt(request.getParameter("bno"));
		int cno = Integer.parseInt(request.getParameter("cno"));

		commentService.updateComment(cno, ccontent);
		redirectAttributes.addAttribute("bno", bno);
		return "redirect:boardView.do";
	}

	@RequestMapping("commentDelete.do") // 댓글 삭제 - 김예찬 10/19
	public String deleteComment(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		int bno = Integer.parseInt(request.getParameter("bno"));
		int cno = Integer.parseInt(request.getParameter("cno"));
		redirectAttributes.addAttribute("bno", bno);
		commentService.deleteComment(cno);
		return "redirect:boardView.do";
	}

	@RequestMapping("boardLike.do") // 게시판 좋아요 기능 - 김예찬 10/14
	public String boardLike(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		MemberDTO dto = (MemberDTO) request.getSession().getAttribute("client");
		response.setContentType("text/html;charset=utf-8");
		JSONObject json = new JSONObject();
		if (dto == null) {
			json.put("msg", "로그인하셔야 이용하실수 있습니다.");
			json.put("code", 400);
			response.getWriter().write(json.toString());
			return null;
		}
		boolean result = boardService.insertBoardLike(bno, dto.getId());
		String msg = result ? "좋아요 표시를 했습니다." : "좋아요를 취소했습니다.";
		json.put("msg", msg);
		json.put("code", 200);
		response.getWriter().write(json.toString());
		return null;
	}

	@RequestMapping("boardHate.do") // 게시판 싫어요 기능 - 김예찬 10/14
	public String boardHate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int bno = Integer.parseInt(request.getParameter("bno"));
		MemberDTO dto = (MemberDTO) request.getSession().getAttribute("client");
		response.setContentType("text/html;charset=utf-8");
		JSONObject json = new JSONObject();
		if (dto == null) {
			json.put("msg", "로그인하셔야 이용하실수 있습니다.");
			json.put("code", 400);
			response.getWriter().write(json.toString());
			return null;
		}
		boolean result = boardService.insertBoardHate(bno, dto.getId());
		String msg = result ? "싫어요 표시를 했습니다." : "싫어요를 취소했습니다.";
		json.put("msg", msg);
		json.put("code", 200);
		response.getWriter().write(json.toString());
		return null;
	}

	@RequestMapping("mypageView.do") // 마이페이지로 이동 - 엄상원 10/21
	public String mypageView(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		String id = ((MemberDTO) session.getAttribute("client")).getId();
		List<Map<String, Object>> flist = memberService.selectAllFavorite(id);
		request.setAttribute("flist", flist);
		List<Map<String, Object>> plist = memberService.selectAllPosition(id);
		request.setAttribute("plist", plist);
		System.out.println("plist : " + plist.toString());
		return "member/mypage";
	}

	@RequestMapping("favoritedelete.do") // 마이페이지 관심종목 삭제 - 엄상원 10/21
	public String favoriteDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {
		response.setContentType("text/html;charset=utf-8");
		String id = ((MemberDTO) session.getAttribute("client")).getId();
		int ino = Integer.parseInt(request.getParameter("ino"));
		if (ino == 0) {
			response.getWriter().write("<script>alert('삭제 실패');history.back()</script>");
		}
		int result = memberService.deleteFavorite(ino);
		List<Map<String, Object>> flist = memberService.selectAllFavorite(id);
		JSONArray arr = new JSONArray(flist);
		response.getWriter().write(arr.toString());
		return null;
	}
}
