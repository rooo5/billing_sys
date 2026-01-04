// app/assets/javascripts/billing.js

function addItem() {
    const items = document.getElementById("items");
    const template = document.querySelector(".item").cloneNode(true);
    template.querySelector("select").value = "";
    template.querySelector("input").value = "";
    items.appendChild(template);
}

function removeItem(button) {
    const items = document.getElementById("items");
    if (items.children.length > 1) {
        button.parentElement.remove();
        calculateTotal();
    }
}

function updateMaxQty(select) {
    const stock = select.options[select.selectedIndex].dataset.stock;
    select.parentElement.querySelector("input").max = stock;
}

function calculateTotal() {
    let total = 0;

    document.querySelectorAll(".item").forEach(item => {
        const select = item.querySelector("select");
        const qty = item.querySelector("input").value;

        if (!select.value || !qty) return;

        const price = parseFloat(select.selectedOptions[0].dataset.price);
        const tax = parseFloat(select.selectedOptions[0].dataset.tax);
        const base = price * qty;

        total += base + (base * tax / 100);
    });

    document.getElementById("total").innerText = total.toFixed(2);
}

function calculatePaidAmount() {
    let paid = 0;

    document.querySelectorAll("[data-value]").forEach(input => {
        paid += parseInt(input.dataset.value) * parseInt(input.value || 0);
    });

    document.getElementById("paid_amount").innerText = paid.toFixed(2);
}
