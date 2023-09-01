"use server"

import axios from "./axios";
import { cookies } from "next/headers";

export async function deleteComment (id)  {
    try{
        const response = await axios.delete(`api/comments/${id}/destroy`, {
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        return response.status
    }
    catch(err){
        return err.response.status
    }
}

export async function patchComment (postId, content, commentId) {
    try{
        const response = await axios.patch(`api/comments/posts/${postId}/update`, { 
            content: content, 
            id: commentId 
        }, {
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        return response.status
    }
    catch(err){
        return err.response.status
    }
}

export async function StoreComment (postID, content){
    try{
        const response = await axios.post(`/api/comments/posts/${postID}`, {
            content: content
        }, {
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        return response.status
    }
    catch(err){
        return err.response.status
    }
}