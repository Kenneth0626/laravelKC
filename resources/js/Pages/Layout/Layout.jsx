import React, { Children } from "react"
import Header from "../Components/Header"
import Navigation from "../Components/Navigation"
import Body from "../Components/Body"
import Footer from "../Components/Footer"

class Layout extends React.Component {
    render(){
        return (
            <>
                <Header>
                    <Navigation />
                </Header>
                <Body>
                    {this.props.children}
                </Body>
                <Footer />
            </>
        )
    }
}

export default Layout