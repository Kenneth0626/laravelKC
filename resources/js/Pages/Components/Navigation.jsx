import React, { Children } from "react"

class Navigation extends React.Component {
    render(){
        return (
            <nav className="bg-red-500 py-4 mt-4 flex w-full rounded-lg">
                <a className="mx-auto">
                    Navigation
                </a>
            </nav>
        )
    }
}

export default Navigation