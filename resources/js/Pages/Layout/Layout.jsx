import Header from "../Components/Header"
import Navigation from "../Components/Navigation"
import Body from "../Components/Body"
import Footer from "../Components/Footer"

export default function Layout ({ children }){
    return (
        <>
            <Header>
                <Navigation />
            </Header>
            <Body>
                {children}
            </Body>
            <Footer />
        </>
    )
}