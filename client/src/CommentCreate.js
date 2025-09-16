import React from "react";
import axios from "axios";
import { useState } from "react";

export default function CommentCreate({ postId, onCommentCreated }) {

    const [content, setContent] = useState('');

    const onSubmit = async (event) => {
        event.preventDefault();
        await axios.post(`/posts/${postId}/comments`, {
            content
        });
        setContent('');
        if (onCommentCreated) {
            onCommentCreated();
        }
    };

    return (
        <div>
            <form onSubmit={onSubmit}>
                <div className="form-group">
                    <label>New Comment</label>
                    <input value={content} onChange={e => setContent(e.target.value)} className="form-control" />
                </div>
                <button className="btn btn-primary">Submit</button>
            </form>
        </div>
    );
}