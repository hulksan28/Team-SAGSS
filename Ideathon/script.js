// Function to calculate the total amount
function calculateTotalAmount() {
  const foodItems = document.querySelectorAll('.food-item');
  let totalAmount = 0;

  foodItems.forEach(item => {
    const itemName = item.querySelector('label').textContent;
    const itemPrice = parseFloat(item.querySelector('.item-price').textContent.replace('₹', ''));
    const itemQuantity = parseInt(item.querySelector('input[type="number"]').value);

    if (itemQuantity > 0) {
      const itemTotal = itemPrice * itemQuantity;
      totalAmount += itemTotal;
      console.log(`${itemName}: ${itemQuantity} x ₹${itemPrice} = ₹${itemTotal}`);
    }
  });

  document.getElementById('total').value = totalAmount.toFixed(2);
}

// Function to handle form submissions
function handleSubmit(event) {
  event.preventDefault();

  // Get form data
  const formData = new FormData(event.target);

  // Send form data to server or perform necessary actions
  console.log('Order Details:');
  formData.forEach((value, key) => {
    console.log(`${key}: ${value}`);
  });

  // Reset form fields
  event.target.reset();
  document.getElementById('total').value = '0';
}

// Add event listeners for form submissions and quantity changes
document.getElementById('foodOrderForm').addEventListener('submit', handleSubmit);
document.querySelectorAll('.food-item input[type="number"]').forEach(input => {
  input.addEventListener('input', calculateTotalAmount);
});	

document.getElementById('start-date').addEventListener('change', function() {
  var startDate = new Date(this.value);
  var endDate = new Date(startDate);
  endDate.setDate(endDate.getDate() + 7); // Adding 7 days to start date
  var endDateFormatted = endDate.toISOString().slice(0, 10);
  document.getElementById('end-date').value = endDateFormatted;
});