import React, { Children } from "react"

class Body extends React.Component {
    render(){
        return (
            <div className="m-10 rounded-lg border-black border-2 p-10 max-w-[110rem] min-w-[110rem]">
                {this.props.children}
            </div>
        )
    }
}

export default Body