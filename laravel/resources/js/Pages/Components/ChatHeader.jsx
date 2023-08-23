
export default function ChatHeader ({ chatName, onlineCount, children }) {
    return (
        <>
            <div className="px-5 flex justify-between">
            
                <div className="flex space-x-5 ">
                    
                    <h1 className="text-3xl">
                        { chatName }
                    </h1>
                    
                    <h2 className="mt-auto text-base">
                        { onlineCount } Online
                    </h2>

                </div>

                <div className="flex flex-row space-x-5">
                    { children }
                </div>

            </div>

            <hr className="border-t-4 border-black rounded-full mx-5 my-2" />
        </>
    )
}