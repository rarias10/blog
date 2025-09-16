import React from "react";
import CommentCreate from "./CommentCreate";
import CommentList from "./CommentList";

export default function PostList({ posts, onCommentCreated }) {

  const renderedPosts = Object.values(posts).map(post => {
    return (
      <div className="card" style={{width: '30%', marginBottom: '20px'}} key={post.id}>
        <div className="card-body">
        <h3>{post.title}</h3>
        <CommentList comments={post.comments} />
        <CommentCreate postId={post.id} onCommentCreated={onCommentCreated} />
        </div>
      </div>
    );
  });

  return (
    <div className="d-flex flex-row flex-wrap justify-content-between">
      <h1>Posts</h1>
      {renderedPosts}
    </div>
  );
}