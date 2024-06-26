// Function to handle form submissions
// Function to handle form submissions
function handleSubmit(event) {
  event.preventDefault();

  // Get form data
  const formData = new FormData(event.target);

  // Send form data to server or perform necessary actions
  console.log('Start Date:', formData.get('start-date'));
  console.log('End Date:', formData.get('end-date'));
  console.log('Floor:', formData.get('floor'));

  // Reset form fields
  event.target.reset();
}

// Add event listener for form submission
document.getElementById('lockerBookingForm').addEventListener('submit', handleSubmit);


// Function to handle like button click
function handleLike(event) {
  const likeButton = event.target;
  const postId = likeButton.dataset.postId;

  // Send a request to the server to increment the like count for the post
  // Example: sendLikeRequest(postId);

  // Update the UI to reflect the new like count
  // Example: updateLikeCount(postId, newLikeCount);
}

// Function to handle comment button click
function handleComment(event) {
  const commentButton = event.target;
  const postId = commentButton.dataset.postId;

  // Show a comment input field or modal for the user to enter their comment
  // Example: showCommentInput(postId);
}

// Add event listeners for form submissions and button clicks
document.querySelectorAll('form').forEach(form => {
  form.addEventListener('submit', handleSubmit);
});

document.querySelectorAll('.post-actions .like-button').forEach(likeButton => {
  likeButton.addEventListener('click', handleLike);
});

document.querySelectorAll('.post-actions .comment-button').forEach(commentButton => {
  commentButton.addEventListener('click', handleComment);
});

window.addEventListener('scroll', function() {
  const bgImage = document.querySelector('.bg-image');
  const scrollPosition = window.pageYOffset;
  const maxScroll = window.innerHeight * 0.5; // Adjust this value as needed

  if (scrollPosition <= maxScroll) {
    const brightness = 0.5 + (scrollPosition / maxScroll) * 0.5;
    bgImage.style.filter = `brightness(${brightness})`;
  } else {
    bgImage.style.filter = 'brightness(1)';
  }
});