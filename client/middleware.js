
import { NextResponse } from "next/server"
import { authPost } from "./lib/authentication"
import { authUser } from "./lib/authentication"

export default async function middlware(request){

    if(request.nextUrl.pathname.includes("edit")){

        const postId = request.nextUrl.pathname.split('/')[2]

        const response = await authPost(postId, request.cookies.get('Bearer'))

        if(response === "none"){
            return NextResponse.redirect(new URL('/', request.url))
        }

        if(response === false){
            return NextResponse.redirect(new URL('/posts', request.url))
        }

    }

    if(request.nextUrl.pathname === "/"){
        
        const response = await authUser(request.cookies.get('Bearer'))

        if(response === 200){
            return NextResponse.redirect(new URL('/posts', request.url))
        }

    }
        
    if(request.nextUrl.pathname.includes("create")){
        
        const response = await authUser(request.cookies.get('Bearer'))

        if(response !== 200){
            return NextResponse.redirect(new URL('/', request.url))
        }

    }

}

export const config = {
    matcher: [
        '/',
        '/posts/create',
        '/posts/:path*/edit',
    ]
}