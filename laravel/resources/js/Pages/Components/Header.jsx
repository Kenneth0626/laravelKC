
export default function Header ({ children }) {
    return (
        <header className=" text-4xl pb-7 pt-8 px-10 w-full block bg-green-500 mt-10 mx-10 rounded-lg max-w-[110rem] min-w-[110rem] h-fit"> 
            <h1>
                Header
            </h1>
            {children}
        </header> 
    )
}