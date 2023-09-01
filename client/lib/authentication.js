"use server"

import axios from "./axios";
import { cookies } from 'next/headers';

export async function storeUser (username, email, password, passswordConfirmation) {
    try{
        const response = await axios.post('api/register', {
            username: username,
            email: email,
            password: password,
            password_confirmation: passswordConfirmation
        })
        
        cookies().set('Bearer', response.data.data.token, { httpOnly: true })

        return response.status
    }
    catch(err){
        return err.response.data
    }
}

export async function authLogin ( email, password ) {
    try{
        await axios.get('sanctum/csrf-cookie')

        const response = await axios.post('api/login', { email: email, password: password })

        cookies().set('Bearer', response.data.data.token, { httpOnly: true })

        return response.status
    }
    catch(err){
        return err.response.data
    }
}

export async function authLogout () {
    try{
        const response = await axios.post('api/logout', null, {
            headers: {
                "Authorization": `Bearer ${cookies().get('Bearer')?.value}`
            }
        })

        cookies().delete('Bearer')
        
        return response.status
    }
    catch(err){
        return err.response.status
    }
}

export async function getUser() {
    try{
        const response = await axios.get('api/user', {
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

// Axios doesn't work in middlware
export async function authPost (postId, token) {
    try{        
        const response = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/posts/edit/check/${postId}`,{
            method: "GET",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": `Bearer ${token.value}`
            }
        })

        const data = await response.json()

        return data?.isOwner
    }
    catch(err){
        return "none"
    }
}

// Axios doesn't work in middlware
export async function authUser (token) {
    try{
        const response = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/user`,{
            method: "GET",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": `Bearer ${token.value}`
            }
        })

        const data = await response.json()

        return data ? 200 : 401
    }
    catch(err){
        return "none"
    }
}