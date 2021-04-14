function priceAdd() {

    const priceInput = document.getElementById("item-price");
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");
    
    priceInput.addEventListener("input", () => {
        const inputValue = priceInput.value;
        const addTax = Math.floor(inputValue * 0.1);
        addTaxDom.innerHTML = addTax
        profitDom.innerHTML = Math.floor(inputValue - addTax);
    })
    
    
}

window.addEventListener("load", priceAdd)





