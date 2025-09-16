import React, { useState, useEffect } from 'react';
import axios from 'axios';
import PostCreate from './PostCreate';
import PostList from './PostList';

export default function App() {
  const [posts, setPosts] = useState({});
  
  const fetchPosts = async () => {
    try {
      const res = await axios.get("http://3.22.77.242:4002/posts");
      setPosts(res.data);
    } catch (error) {
      console.error("Error fetching posts:", error);
    }
  };
  
  useEffect(() => {
    fetchPosts();
  }, []);

  return (
    <div className="container">
      <h1>Hello World</h1>
      <PostCreate onPostCreated={fetchPosts} />
      <hr />
      <PostList posts={posts} onCommentCreated={fetchPosts} />
    </div>
  );
}
