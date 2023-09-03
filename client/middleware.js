
import { NextResponse } from "next/server"
import { authPost } from "./lib/authentication"
import { authUser } from "./lib/authentication"

export default async function middlware(request){

    const urlParts = request.nextUrl.pathname.split('/')

    
    if(urlParts.length === 4, urlParts[1] === "posts", urlParts[3] === "edit"){

        if( isNaN(urlParts[2] )){
            return NextResponse.redirect(new URL('/posts', request.url))
        }

        const response = await authPost(urlParts[2], request.cookies.get('Bearer'))

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
        
    if(urlParts.length === 3 && urlParts[1] === "posts" && urlParts[2] === "create"){
        
        const response = await authUser(request.cookies.get('Bearer'))

        if(response !== 200){
            return NextResponse.redirect(new URL('/', request.url))
        }

    }

    if(urlParts.length === 3 && urlParts[1] === "posts" && isNaN(urlParts[2])){
        return NextResponse.redirect(new URL('/posts', request.url))
    }

}

export const config = {
    matcher: [
        '/',
        '/posts/create',
        '/posts/:path*/edit',
        '/posts/:path*',
    ]
}