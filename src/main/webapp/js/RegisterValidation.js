window.App = window.App || {};
App.initRegisterValidation = function (serverErrors) {

    const form = document.getElementById('registerForm');
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');
    const dateOfBirth = document.getElementById('dateOfBirth');

	

    // check date: must be at least 16 years old
    if (dateOfBirth) {
        const maxDate = new Date();
        maxDate.setFullYear(maxDate.getFullYear() - 16);
        dateOfBirth.max = maxDate.toISOString().split('T')[0];

        dateOfBirth.addEventListener('input', () => {
            const dob = new Date(dateOfBirth.value);
            const today = new Date();
            let age = today.getFullYear() - dob.getFullYear();
            const m = today.getMonth() - dob.getMonth();
            if (m < 0 || (m === 0 && today.getDate() < dob.getDate())) age--;
            dateOfBirth.setCustomValidity(age < 16 ? "You must be at least 16 years old." : "");
        });
    }
	

    // check passwords are equal
    if (confirmPassword && password) {
        const checkMatch = () => {
            confirmPassword.setCustomValidity(
                confirmPassword.value !== password.value ? "Passwords do not match." : ""
            );
        };
        confirmPassword.addEventListener('input', checkMatch);
        password.addEventListener('input', () => {
            if (confirmPassword.value !== '') checkMatch();
        });
    }

    // Server errors
    Object.entries(serverErrors).forEach(([field, message]) => {
        const input = document.getElementsByName(field)[0];
        if (input) {
            input.setCustomValidity(message);
            input.reportValidity();
            input.addEventListener('input', () => {
                input.setCustomValidity('');
                input.reportValidity();
            });
        }
    });

    // Final submit check
    form.addEventListener('submit', event => {
        if (confirmPassword && password) {
            confirmPassword.setCustomValidity(
                confirmPassword.value !== password.value ? "Passwords do not match." : ""
            );
        }
        if (!form.checkValidity()) {
            event.preventDefault();
            form.reportValidity();
        }
    });
};

