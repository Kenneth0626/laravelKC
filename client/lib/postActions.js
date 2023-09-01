"use server"

import axios from "./axios";
import { cookies } from "next/headers";

export async function deletePost (id) {
    try{
        const response = await axios.delete(`api/posts/${id}/destroy`, {
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        return response.status
    }
    catch(err){
        return err.response.data
    }
}

export async function getEditablePostData (url) {
    try{
        const response = await axios.get(`/api/${url}`,{
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        return response.data.data
    }
    catch(err){
        return err.response.status
    } 
}

export async function getPostComments (url) {
    try{
        const response = await axios.get(`/api/posts/comments/${url}`,{
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        return response.data.data
    }
    catch(err){
        return err.response.status
    }
}

export async function getPostData (url) {
    try{
        const response = await axios.get(`/api/${url}`,{
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })
        
        return response.data.data
    }
    catch(err){
        return err.response.status
    }
}

export async function getPosts (url) {
    try{
        const response = await axios.get(`/api/${url}`,{
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        return response.data.data
    }
    catch(err){
        return err.response.data
    }
    
}

export async function patchPost (postID, title, content) {
    try{
        const response = await axios.patch(`api/posts/${postID}/update`, {
            title: title,
            content: content
        }, {
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        return response.status
    }
    catch(err){
        return err.response.data
    }
}

export async function storePost (title, content) {
    try{
        const response = await axios.post('api/posts/create', {
            title: title,
            content: content
        },{
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        return response.status
    }
    catch(err){
        return err.response.data
    }
}