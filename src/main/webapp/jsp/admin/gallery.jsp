<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<% if (session.getAttribute("loggedAdmin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login"); return; } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery | RK GROUP Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">
</head>
<body>
<div class="admin-wrapper">
    <aside class="sidebar">
        <div class="sidebar-brand"><h6><i class="bi bi-gem me-2"></i>RK GROUP</h6><small>Admin Panel</small></div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/gallery" class="active"><i class="bi bi-images"></i> Gallery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-box-seam"></i> Products</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/inquiries"><i class="bi bi-chat-dots"></i> Inquiries</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bookings"><i class="bi bi-calendar-check"></i> Bookings</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/sites"><i class="bi bi-building"></i> Work Sites</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/workers"><i class="bi bi-people"></i> Workers</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </aside>
    <div class="main-content">
        <div class="topbar">
            <h5><i class="bi bi-images me-2" style="color:var(--primary);"></i>Gallery Management</h5>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
        </div>
        <div class="page-content">
            <div class="page-header">
                <h4>Gallery <span>Projects</span></h4>
                <button class="btn-admin-primary" data-bs-toggle="modal" data-bs-target="#addGalleryModal">
                    <i class="bi bi-cloud-upload me-1"></i>Upload New Project
                </button>
            </div>

            <!-- Gallery Grid -->
            <c:choose>
                <c:when test="${not empty galleryList}">
                    <div class="row g-3">
                        <c:forEach var="g" items="${galleryList}">
                            <div class="col-lg-3 col-md-4 col-sm-6">
                                <div style="background:var(--dark-2);border:1px solid var(--dark-4);border-radius:var(--radius);overflow:hidden;">
                                    <c:choose>
                                        <c:when test="${not empty g.imageFilename}">
                                            <img src="${pageContext.request.contextPath}/uploads/${g.imageFilename}"
                                                 alt="${g.title}" style="width:100%;height:180px;object-fit:cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="height:180px;background:var(--dark-3);display:flex;align-items:center;justify-content:center;">
                                                <i class="bi bi-image" style="font-size:2.5rem;color:var(--muted);opacity:0.3;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div style="padding:14px;">
                                        <div class="d-flex justify-content-between align-items-start mb-1">
                                            <h6 style="font-size:0.88rem;margin:0;flex:1;margin-right:8px;">${g.title}</h6>
                                            <c:choose>
                                                <c:when test="${g.active}"><span class="badge-active" style="white-space:nowrap;">Active</span></c:when>
                                                <c:otherwise><span class="badge-rejected" style="white-space:nowrap;">Hidden</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <small style="color:var(--primary);font-size:0.76rem;">${g.categoryName}</small>
                                        <c:if test="${not empty g.location}">
                                            <p style="color:var(--muted);font-size:0.78rem;margin:4px 0 0;"><i class="bi bi-geo-alt me-1"></i>${g.location}</p>
                                        </c:if>
                                        <div class="d-flex gap-1 mt-2">
                                            <%-- Edit button - sirf active items ke liye --%>
                                            <button class="btn-admin-sm btn-edit btn-open-edit flex-grow-1"
                                                    data-bs-toggle="modal" data-bs-target="#editGalleryModal"
                                                    data-id="${g.id}" data-title="${g.title}"
                                                    data-description="${g.description}" data-location="${g.location}"
                                                    data-categoryid="${g.categoryId}"
                                                    data-completiondate="${g.completionDate}"
                                                    data-isactive="${g.active ? '1' : '0'}">
                                                <i class="bi bi-pencil me-1"></i>Edit
                                            </button>

                                            <c:choose>
                                                <c:when test="${g.active}">
                                                    <%-- Active item: Hide karo (soft delete) --%>
                                                    <form action="${pageContext.request.contextPath}/admin/gallery" method="post" style="display:inline;" title="Hide from public gallery">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${g.id}">
                                                        <button type="submit" class="btn-admin-sm btn-delete"
                                                                style="background:rgba(240,168,48,0.15);color:#f0a830;border:1px solid #f0a830;"
                                                                onclick="return confirm('Is project ko gallery se hide karein?')">
                                                            <i class="bi bi-eye-slash"></i>
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <%-- Hidden item: Permanently DELETE karo --%>
                                                    <form action="${pageContext.request.contextPath}/admin/gallery" method="post" style="display:inline;" title="Permanently Delete">
                                                        <input type="hidden" name="action" value="permanentDelete">
                                                        <input type="hidden" name="id" value="${g.id}">
                                                        <button type="submit" class="btn-admin-sm btn-delete"
                                                                style="background:rgba(224,82,82,0.3);color:#e05252;border:1px solid #e05252;font-weight:700;"
                                                                onclick="return confirm('PERMANENTLY delete karein? Yeh wapis nahi aayega!')">
                                                            <i class="bi bi-trash-fill"></i> Del
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align:center;padding:60px 20px;background:var(--dark-2);border:1px solid var(--dark-4);border-radius:var(--radius);">
                        <i class="bi bi-images" style="font-size:3rem;color:var(--muted);opacity:0.3;"></i>
                        <p style="color:var(--muted);margin-top:16px;">No gallery items yet. Click "Upload New Project" to add your first project photo.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- ADD Gallery Modal -->
<div class="modal fade" id="addGalleryModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="background:var(--dark-2);border:1px solid var(--dark-3);color:var(--light);">
            <div class="modal-header" style="border-color:var(--dark-3);">
                <h5 class="modal-title" style="color:var(--primary);"><i class="bi bi-cloud-upload me-2"></i>Upload Project</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/gallery" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="action" value="add">
                <div class="modal-body admin-form-card" style="border:none;">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label class="form-label">Project Title *</label>
                            <input type="text" class="form-control" name="title" required placeholder="e.g. Modern Villa Interior – Bhopal">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Category</label>
                            <select class="form-select" name="categoryId">
                                <option value="1">Interior Design</option>
                                <option value="2">Furniture</option>
                                <option value="3">Modular Kitchen</option>
                                <option value="4">Door Work</option>
                                <option value="5">False Ceiling</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Location</label>
                            <input type="text" class="form-control" name="location" placeholder="e.g. Arera Colony, Bhopal">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Completion Date</label>
                            <input type="date" class="form-control" name="completionDate">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Project Description</label>
                            <textarea class="form-control" name="description" rows="3" placeholder="Brief description of the work done..."></textarea>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Project Image *</label>
                            <input type="file" class="form-control image-upload" name="image" accept="image/*" required>
                            <img id="imgPreview" src="#" alt="Preview" style="display:none;max-height:120px;margin-top:10px;border-radius:8px;">
                            <small style="color:var(--muted);">Max 5MB. Formats: JPG, PNG, WEBP</small>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-color:var(--dark-3);">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-admin-primary"><i class="bi bi-cloud-upload me-1"></i>Upload Project</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- EDIT Gallery Modal -->
<div class="modal fade" id="editGalleryModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="background:var(--dark-2);border:1px solid var(--dark-3);color:var(--light);">
            <div class="modal-header" style="border-color:var(--dark-3);">
                <h5 class="modal-title" style="color:var(--primary);"><i class="bi bi-pencil me-2"></i>Edit Project</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form id="editForm" action="${pageContext.request.contextPath}/admin/gallery" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id">
                <div class="modal-body admin-form-card" style="border:none;">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label class="form-label">Project Title</label>
                            <input type="text" class="form-control" name="title" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Category</label>
                            <select class="form-select" name="categoryId">
                                <option value="1">Interior Design</option>
                                <option value="2">Furniture</option>
                                <option value="3">Modular Kitchen</option>
                                <option value="4">Door Work</option>
                                <option value="5">False Ceiling</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Location</label>
                            <input type="text" class="form-control" name="location">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Completion Date</label>
                            <input type="date" class="form-control" name="completiondate">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Visible?</label>
                            <select class="form-select" name="isActive">
                                <option value="1">Yes (Visible)</option>
                                <option value="0">No (Hidden)</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Replace Image (optional)</label>
                            <input type="file" class="form-control image-upload" name="image" accept="image/*">
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-color:var(--dark-3);">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-admin-primary">Update Project</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
