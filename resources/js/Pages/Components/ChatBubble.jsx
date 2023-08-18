
export default function ChatBubble ({ isSender, isSending = false, name, content, time }) {

    const bubbleType = {
        justify: isSender === true ? "justify-end" : "justify-right",
        color: isSending === true ? "bg-slate-200" : (isSender === true ? "bg-green-200" : "bg-blue-200"),
        sending: isSending === true ? "border-white" : "border-black",
    }

    return (
        <div className={`flex ${ bubbleType.justify }`}>

            <div className={`mx-5 w-fit border-2 rounded-lg p-2 max-w-[48rem] ${ bubbleType.color } ${ bubbleType.sending }`}>
                
                <div className="flex space-x-2">

                    <h1 className="font-bold text-base">
                        { name } 
                    </h1>

                    { isSending === true ? 
                        ( 
                            <span className="text-xs my-auto italic"> 
                                sending... 
                            </span> 
                        ) : 
                        ( 
                            <span className="text-xs my-auto"> 
                                { `[${ time.slice(11, 19) }]` } 
                            </span> 
                        ) 
                    }
                    
                </div>

                <p className="whitespace-normal text-base">
                    { content }
                </p>

            </div>
            
        </div>
    )
}