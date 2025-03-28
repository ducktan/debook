// Xử lý nút Thả tim
const likeBtn = document.getElementById('like-btn');
const likeCount = document.getElementById('like-count');
let likes = 5;
let isLiked = false;

likeBtn.addEventListener('click', () => {
    if (!isLiked) {
        likes++;
        likeBtn.classList.add('liked');
        likeBtn.innerHTML = '<i class="fas fa-heart"></i> Đã thích';
        isLiked = true;
    } else {
        likes--;
        likeBtn.classList.remove('liked');
        likeBtn.innerHTML = '<i class="far fa-heart"></i> Thả tim';
        isLiked = false;
    }
    likeCount.textContent = `${likes} lượt thích`;
});

// Xử lý hiển thị/ẩn bình luận
const commentBtn = document.getElementById('comment-btn');
const commentsSection = document.getElementById('comments-section');

commentBtn.addEventListener('click', () => {
    commentsSection.style.display = commentsSection.style.display === 'block' ? 'none' : 'block';
});

// Xử lý thêm bình luận
const commentInput = document.getElementById('comment-input');
const submitComment = document.getElementById('submit-comment');
const commentList = document.getElementById('comment-list');

submitComment.addEventListener('click', () => {
    const commentText = commentInput.value.trim();
    if (commentText) {
        const comment = document.createElement('div');
        comment.classList.add('comment');
        comment.textContent = commentText;
        commentList.appendChild(comment);
        commentInput.value = ''; // Xóa input sau khi gửi
    }
});

// Gửi bình luận bằng phím Enter
commentInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        submitComment.click();
    }
});