package controller;

import dao.BookingDAO;
import model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({"/booking", "/admin/bookings"})
public class BookingServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/bookings")) {
            if (!AdminServlet.isLoggedIn(req)) {
                resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
            }
            req.setAttribute("bookings", bookingDAO.getAllBookings());
            req.getRequestDispatcher("/jsp/admin/bookings.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/jsp/public/booking.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/admin/bookings")) {
            if (!AdminServlet.isLoggedIn(req)) {
                resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
            }

            // FIX: id empty string crash fix — null/empty check pehle karo
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/admin/bookings");
                return;
            }

            int    id         = Integer.parseInt(idParam.trim());
            String status     = req.getParameter("status");
            String adminNotes = req.getParameter("adminNotes");

            if (status == null) status = "pending";
            if (adminNotes == null) adminNotes = "";

            bookingDAO.updateStatus(id, status, adminNotes);
            resp.sendRedirect(req.getContextPath() + "/admin/bookings");

        } else {
            // Public booking form
            String customerName = req.getParameter("customerName");
            String phone        = req.getParameter("phone");
            String visitDate    = req.getParameter("visitDate");

            if (customerName == null || customerName.isEmpty() ||
                phone == null || phone.isEmpty() ||
                visitDate == null || visitDate.isEmpty()) {
                req.setAttribute("error", "Please fill in all required fields.");
                req.getRequestDispatcher("/jsp/public/booking.jsp").forward(req, resp);
                return;
            }

            Booking b = new Booking();
            b.setCustomerName(customerName.trim());
            b.setPhone(phone.trim());
            b.setEmail(req.getParameter("email"));
            b.setAddress(req.getParameter("address"));
            b.setVisitDate(visitDate);
            b.setMessage(req.getParameter("message"));

            boolean saved = bookingDAO.addBooking(b);
            req.setAttribute(saved ? "success" : "error",
                saved ? "Booking submitted! We will confirm soon." : "Booking failed. Try again.");
            req.getRequestDispatcher("/jsp/public/booking.jsp").forward(req, resp);
        }
    }
}
