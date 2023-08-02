
import { Link } from '@inertiajs/react';
import React, { useMemo } from 'react';
  
export default function Pagination ({ links }) {

    // Get current active page number
    const currentPage = ()  => {
        return (links[0].url === null) ? 1 : parseInt(links[0].url.split("=")[1]) + 1
    }

    // Generate pagination links
    const newLinks = useMemo(() => {

        // Displays how many links should show next to active page link
        const linksOnEachSide = 4

        const linksLastIndex = links.length - 1

        // Get number of links to display left of active page link
        const startLinkDisplay = () => {
            const startingLink = currentPage() - linksOnEachSide
            return (startingLink < 2) ? 2 : startingLink
        }

        // Get number of links to display right of active page link
        const endLinkDisplay = () => {
            const endLink = currentPage() + linksOnEachSide + 1 
            return (endLink > links.length - 2) ? links.length - 2 : endLink
        }

        // Form new array to display page links
        const initialLinks = [links[0], links[1], links[linksLastIndex - 1], links[linksLastIndex]]
        const slicedLinks = links.slice(startLinkDisplay(), endLinkDisplay())
        initialLinks.splice(2, 0, ...slicedLinks)

        return initialLinks

    }, [ window.location.href, links.length ]) 

    function cleanLabel(label){
        if(label === "&laquo; Previous"){
            return "<"
        }
        if(label === "Next &raquo;"){
            return ">"
        }
        return label
    }

    function linkActive(url, isActive){
        if(url === null){
            return "border-black bg-slate-200"
        }
        if(isActive){
            return "border-red-600 bg-red-200"
        }
        return "border-green-600 bg-green-200"
    }

    return (
        <div className="flex min-w-[50rem] justify-end mx-[15rem]">
            {links.length > 3 && (
                <div className="bg-slate-400 border-slate-600 border-4 flex space-x-1 py-2 px-2 rounded-xl">
                    { newLinks.map((link, index) => (
                        <span
                            className={`border-4 text-xl font-bold rounded-xl w-fit h-fit ${linkActive(link.url, link.active)}`}
                            key={index}
                        >        
                            <Link 
                                href={link.url}
                                className="inline-block relative px-[0.8rem] py-[0.1rem] text-center"
                            >   
                                {cleanLabel(link.label)}
                            </Link>
                        </span>
                    ))}
                </div>
            )}  
        </div> 
    )     
}