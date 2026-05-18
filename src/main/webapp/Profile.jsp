<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<c:choose>
<c:when test="${not empty user}">

<div class="w3-white w3-round w3-card w3-section" style="overflow:hidden;">

    <div style="height:5px; background:linear-gradient(90deg, var(--orange), var(--orange-light), var(--green));"></div>

    <!-- Avatar + name -->
    <div class="w3-center" style="padding:28px 24px 16px;">
        <c:choose>
            <c:when test="${not empty user.picture}">
                <img src="${user.picture}" class="w3-circle"
                     style="height:96px;width:96px;object-fit:cover;border:3px solid var(--orange-light);box-shadow:0 4px 14px rgba(224,123,57,0.25);"
                     alt="Avatar">
            </c:when>
            <c:otherwise>
                <div style="width:96px;height:96px;border-radius:50%;background:linear-gradient(135deg,#fff4eb,#fde8d0);border:3px solid var(--orange-light);display:flex;align-items:center;justify-content:center;font-size:38px;margin:0 auto;">
                    🧑‍🍳
                </div>
            </c:otherwise>
        </c:choose>
        <h3 style="margin:12px 0 4px; color:var(--warm-brown); font-family:'Playfair Display',serif;">
            <c:if test="${not empty user.title}">${user.title} </c:if>
            ${user.firstName} ${user.lastName}
            <c:if test="${user.verified}">
                <span title="Verified" style="font-size:16px;">✅</span>
            </c:if>
        </h3>
        <span class="username-badge">@${user.username}</span>
        <c:if test="${not empty user.bio}">
            <p style="color:var(--muted); font-size:14px; margin:10px auto 0; max-width:320px; line-height:1.6;">
                ${user.bio}
            </p>
        </c:if>
    </div>

    <hr style="border:none; border-top:1px solid #f0e8df; margin:0 24px;">

    <!-- TWO COLUMNS -->
    <div style="display:flex; gap:0; align-items:stretch;">

        <!-- LEFT: read-only info -->
        <div style="flex:1; padding:20px 24px; border-right:1px solid #f0e8df;">
            <p style="font-size:11px; text-transform:uppercase; letter-spacing:1px; color:var(--muted); margin-bottom:14px; font-weight:600;">Your info</p>

            <div style="margin-bottom:12px;">
                <span style="font-size:12px; color:var(--muted); display:block;">Full name</span>
                <span style="font-size:14px; color:var(--warm-brown); font-weight:500;">
                    <c:if test="${not empty user.title}">${user.title} </c:if>${user.firstName} ${user.lastName}
                </span>
            </div>

            <div style="margin-bottom:12px;">
                <span style="font-size:12px; color:var(--muted); display:block;">Username</span>
                <span style="font-size:14px; color:var(--warm-brown); font-weight:500;">@${user.username}</span>
            </div>

            <div style="margin-bottom:12px;">
                <span style="font-size:12px; color:var(--muted); display:block;">Email</span>
                <span style="font-size:14px; color:var(--warm-brown); font-weight:500;">${user.email}</span>
            </div>

            <div style="margin-bottom:12px;">
                <span style="font-size:12px; color:var(--muted); display:block;">Date of birth</span>
                <span style="font-size:14px; color:var(--warm-brown); font-weight:500;">${user.dateOfBirth}</span>
            </div>

            <c:if test="${not empty user.gender}">
                <div style="margin-bottom:12px;">
                    <span style="font-size:12px; color:var(--muted); display:block;">Gender</span>
                    <span style="font-size:14px; color:var(--warm-brown); font-weight:500;">${user.gender}</span>
                </div>
            </c:if>

            <c:if test="${not empty user.phone}">
                <div style="margin-bottom:12px;">
                    <span style="font-size:12px; color:var(--muted); display:block;">Phone</span>
                    <span style="font-size:14px; color:var(--warm-brown); font-weight:500;">${user.phone}</span>
                </div>
            </c:if>

            <c:if test="${not empty user.allergies}">
                <div style="margin-bottom:12px;">
                    <span style="font-size:12px; color:var(--muted); display:block;">Allergies</span>
                    <span style="font-size:14px; color:var(--warm-brown); font-weight:500;">${user.allergies}</span>
                </div>
            </c:if>

            <c:if test="${not empty user.foodPreferences}">
                <div style="margin-bottom:12px;">
                    <span style="font-size:12px; color:var(--muted); display:block; margin-bottom:6px;">Food preferences</span>
                    <div style="display:flex; flex-wrap:wrap; gap:5px;">
                        <c:forTokens items="${user.foodPreferences}" delims="," var="pref">
                            <span style="background:#f0faf5; color:var(--green); border:1px solid rgba(61,122,90,0.2); border-radius:100px; padding:3px 10px; font-size:12px;">
                                ${pref}
                            </span>
                        </c:forTokens>
                    </div>
                </div>
            </c:if>

        </div>

        <!-- RIGHT: editable fields -->
        <c:if test="${user.role != 'admin'}">
        <div style="flex:1; padding:20px 24px;">
            <p style="font-size:11px; text-transform:uppercase; letter-spacing:1px; color:var(--muted); margin-bottom:14px; font-weight:600;">✏️ Edit profile</p>

            <form action="UpdateProfile" method="post">

                <label style="font-size:12px; color:var(--muted); display:block; margin-bottom:4px;">Bio</label>
                <textarea name="bio" rows="2" class="w3-input w3-border w3-round"
                          placeholder="Tell the community about your cooking style… 🍳"
                          style="resize:vertical; font-size:13px; margin-bottom:12px;">${user.bio}</textarea>

                <label style="font-size:12px; color:var(--muted); display:block; margin-bottom:4px;">Phone</label>
                <input type="tel" name="phone" class="w3-input w3-border w3-round"
                       placeholder="+34 600 000 000"
                       value="${user.phone}" style="font-size:13px; margin-bottom:12px;">

                <label style="font-size:12px; color:var(--muted); display:block; margin-bottom:4px;">Allergies</label>
                <input type="text" name="allergies" class="w3-input w3-border w3-round"
                       placeholder="e.g. nuts, gluten, dairy…"
                       value="${user.allergies}" style="font-size:13px; margin-bottom:12px;">

                <label style="font-size:12px; color:var(--muted); display:block; margin-bottom:6px;">Profile picture URL</label>
                <input type="text" name="picture" class="w3-input w3-border w3-round"
                       placeholder="https://…"
                       value="${user.picture}" style="font-size:13px; margin-bottom:12px;">

                <!-- Food preferences multi-select -->
                <label style="font-size:12px; color:var(--muted); display:block; margin-bottom:8px;">Food preferences</label>
                <div style="display:flex; flex-wrap:wrap; gap:7px; margin-bottom:16px;" id="foodPrefGrid">
                    <c:set var="prefs" value="${user.foodPreferences}" />
                    <c:forEach var="option" items="${['Vegetarian','Vegan','Pescatarian','Gluten-free','Dairy-free','Nut-free','Halal','Kosher','Keto','Low-carb','Paleo','Mediterranean','High-protein','Sugar-free','Raw food']}">
                        <label style="cursor:pointer;">
                            <input type="checkbox" name="foodPreferences" value="${option}"
                                   style="display:none;"
                                   class="pref-cb"
                                   <c:if test="${fn:contains(prefs, option)}">checked</c:if>>
                            <span class="pref-tag" style="display:inline-block; background:#fafafa; border:1.5px solid #e0d6ce; border-radius:100px; padding:5px 12px; font-size:12px; color:var(--muted); transition:all 0.15s;">
                                ${option}
                            </span>
                        </label>
                    </c:forEach>
                </div>

                <button type="submit"
                        style="background:linear-gradient(135deg,var(--orange),#c9622a); color:white; border:none; border-radius:10px; padding:10px 18px; font-size:13px; font-weight:500; cursor:pointer; width:100%; box-shadow:0 4px 12px rgba(224,123,57,0.3);">
                    💾 Save changes
                </button>
            </form>
        </div>
        </c:if>

    </div><!-- end two columns -->

</div>

</c:when>
<c:otherwise>
    <div class="w3-container w3-section">
        <p style="color:var(--muted);">Please <a href="Login" class="menu" style="color:var(--orange);">log in</a> to view your profile.</p>
    </div>
</c:otherwise>
</c:choose>

<!-- Checkbox pill styling -->
<style>
    .pref-cb:checked + .pref-tag {
        background: linear-gradient(135deg, #f0faf5, #c8e6d5);
        border-color: rgba(61,122,90,0.4);
        color: var(--green);
        font-weight: 500;
    }
</style>