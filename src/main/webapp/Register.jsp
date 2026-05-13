<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<form id="registerForm" action="Register" method="POST" enctype="multipart/form-data">

    <h3 class="w3-text-theme">Create Account</h3>

    <!-- ACCOUNT -->
    <div>
        <label class="w3-text-theme">Username *</label>
        <input class="w3-input w3-border w3-light-grey" type="text" id="username" name="username"
            required minlength="5" maxlength="20" value="${user.username}"
            title="5-20 characters, no spaces." />
    </div>

    <div>
        <label class="w3-text-theme">Password *</label>
        <input class="w3-input w3-border w3-light-grey" type="password" id="password" name="password"
            required pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$"
            title="Min 8 chars, uppercase, number, special char (!@#$%^&*)." />
    </div>

    <div>
        <label class="w3-text-theme">Confirm Password *</label>
        <input class="w3-input w3-border w3-light-grey" type="password" id="confirmPassword"
            name="confirmPassword" required title="Passwords must match." />
    </div>

    <!-- PERSONAL -->
    <div>
        <label class="w3-text-theme">First Name *</label>
        <input class="w3-input w3-border w3-light-grey" type="text" id="firstName" name="firstName"
            required minlength="2" maxlength="50" value="${user.firstName}" />
    </div>

    <div>
        <label class="w3-text-theme">Last Name *</label>
        <input class="w3-input w3-border w3-light-grey" type="text" id="lastName" name="lastName"
            required minlength="2" maxlength="50" value="${user.lastName}" />
    </div>

    <div>
        <label class="w3-text-theme">Email *</label>
        <input class="w3-input w3-border w3-light-grey" type="email" id="email" name="email"
            required value="${user.email}" />
    </div>

    <div>
        <label class="w3-text-theme">Phone <span style="font-size:0.85em;color:#999">(optional)</span></label>
        <input class="w3-input w3-border w3-light-grey" type="tel" id="phone" name="phone"
            pattern="^[679]\d{8}$" value="${user.phone}"
            title="9 digits starting with 6, 7 or 9." />
    </div>

    <div>
        <label class="w3-text-theme">Date of Birth *</label>
        <input class="w3-input w3-border w3-light-grey" type="date" id="dateOfBirth" name="dateOfBirth"
            required value="${user.dateOfBirth}"
            title="You must be at least 16 years old." />
    </div>

    <div>
        <label class="w3-text-theme">Allergies <span style="font-size:0.85em;color:#999">(optional)</span></label>
        <input class="w3-input w3-border w3-light-grey" type="text" id="allergies" name="allergies"
            maxlength="500" value="${user.allergies}" />
    </div>

    <div>
        <label class="w3-text-theme">Profile Picture <span style="font-size:0.85em;color:#999">(optional)</span></label>
        <input class="w3-input w3-border w3-light-grey" type="file" id="picture" name="picture"
            accept="image/*" />
    </div>

    <button type="submit" class="w3-button w3-theme w3-section">Create Account</button>

</form>

<script>
    App.Errors = {
        <c:forEach var="error" items="${errors}">
            "${error.key}": "${error.value}",
        </c:forEach>
    };
    App.initRegisterValidation(App.Errors);
</script>