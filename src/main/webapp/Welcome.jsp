<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="w3-white w3-round w3-card w3-section" style="overflow:hidden;">
    <div style="height:5px; background:linear-gradient(90deg, var(--orange), var(--orange-light), var(--green));"></div>

    <div style="padding: 28px 24px;">

        <c:if test="${empty user}">
            <div style="display:flex; align-items:center; gap:14px; margin-bottom:16px;">
                <div style="font-size:42px;">🍴</div>
                <div>
                    <h2 style="margin:0; color:var(--warm-brown); font-family:'Playfair Display',serif;">
                        Welcome to Forkful!
                    </h2>
                    <span style="color:var(--muted); font-size:14px;">Browse recipes from our community.</span>
                </div>
            </div>

            <hr style="border:none; border-top:1px solid #f0e8df; margin:16px 0;">

            <p style="color:var(--muted); font-size:14px; margin-bottom:14px;">
                👀 You are browsing as a <strong>guest</strong>. You can read public recipes and posts,
                but you'll need an account to like, comment, post, or follow others.
            </p>

            <div style="display:flex; gap:10px; flex-wrap:wrap;">
                <a href="Register" class="menu" style="text-decoration:none;">
                    <div style="background:linear-gradient(135deg,var(--orange),#c9622a); color:white; border-radius:12px; padding:12px 20px; font-size:14px; font-weight:500; box-shadow:0 4px 12px rgba(224,123,57,0.3);">
                        🌟 Join Forkful
                    </div>
                </a>
                <a href="Login" class="menu" style="text-decoration:none;">
                    <div style="background:#fafafa; border:1.5px solid #f0e8df; border-radius:12px; padding:12px 20px; color:var(--muted); font-size:14px; font-weight:500;">
                        🔑 Log in
                    </div>
                </a>
            </div>
        </c:if>

      
        <c:if test="${not empty user and user.role == 'admin'}">
            <div style="display:flex; align-items:center; gap:14px; margin-bottom:16px;">
                <div style="font-size:42px;">🛡️</div>
                <div>
                    <h2 style="margin:0; color:var(--warm-brown); font-family:'Playfair Display',serif;">
                        Admin Panel
                    </h2>
                    <span class="username-badge">@${user.username}</span>
                </div>
            </div>

            <hr style="border:none; border-top:1px solid #f0e8df; margin:16px 0;">

            <p style="color:var(--muted); font-size:14px; margin-bottom:14px;">
                You have full moderation powers. Use them wisely. 🍳
            </p>

            <div style="display:flex; gap:10px; flex-wrap:wrap;">
                <a href="ManageUsers" class="menu" style="text-decoration:none;">
                    <div style="background:linear-gradient(135deg,#fff4eb,#fde8d0); border:1.5px solid rgba(224,123,57,0.25); border-radius:12px; padding:12px 18px; color:var(--orange); font-size:14px; font-weight:500;">
                        👥 Manage users
                    </div>
                </a>
                <a href="ManagePosts" class="menu" style="text-decoration:none;">
                    <div style="background:#fafafa; border:1.5px solid #f0e8df; border-radius:12px; padding:12px 18px; color:var(--muted); font-size:14px; font-weight:500;">
                        🗑️ Moderate posts
                    </div>
                </a>
            </div>
        </c:if>

        <c:if test="${not empty user and user.role != 'admin'}">
            <div style="display:flex; align-items:center; gap:14px; margin-bottom:16px;">
                <div style="font-size:42px;">🍴</div>
                <div>
                    <h2 style="margin:0; color:var(--warm-brown); font-family:'Playfair Display',serif;">
                        Welcome back, ${user.firstName}!
                        <c:if test="${user.verified}"> <span title="Verified chef" style="font-size:18px;">✅</span></c:if>
                    </h2>
                    <span class="username-badge">@${user.username}</span>
                </div>
            </div>

            <hr style="border:none; border-top:1px solid #f0e8df; margin:16px 0;">

            <p style="color:var(--muted); font-size:14px; margin-bottom:14px;">
                What would you like to cook up today?
            </p>

            <div style="display:flex; gap:10px; flex-wrap:wrap;">
                <a href="Post" class="menu" style="text-decoration:none;">
                    <div style="background:linear-gradient(135deg,#fff4eb,#fde8d0); border:1.5px solid rgba(224,123,57,0.25); border-radius:12px; padding:12px 18px; color:var(--orange); font-size:14px; font-weight:500;">
                        ✍️ Share a recipe
                    </div>
                </a>
                <a href="Feed" class="menu" style="text-decoration:none;">
                    <div style="background:linear-gradient(135deg,#f0faf5,#c8e6d5); border:1.5px solid rgba(61,122,90,0.2); border-radius:12px; padding:12px 18px; color:var(--green); font-size:14px; font-weight:500;">
                        🥗 Browse feed
                    </div>
                </a>
                <a href="Profile" class="menu" style="text-decoration:none;">
                    <div style="background:#fafafa; border:1.5px solid #f0e8df; border-radius:12px; padding:12px 18px; color:var(--muted); font-size:14px; font-weight:500;">
                        👤 My profile
                    </div>
                </a>
            </div>

            <!-- Verification nudge for unverified users -->
            <c:if test="${not user.verified}">
                <p style="margin-top:16px; font-size:13px; color:var(--muted); background:#fafafa; border:1px solid #f0e8df; border-radius:10px; padding:10px 14px;">
                    💡 Your account is not verified yet. An administrator will review your profile — once approved you'll get a ✅ badge!
                </p>
            </c:if>
        </c:if>

    </div>
</div>