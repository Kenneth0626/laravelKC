import ChatBubble from "./ChatBubble"

export default function ChatBox ({ boxStyle, infoRef, guestID, messageData, sendData, bottomRef }) {
    return (
        <div 
            className={`flex flex-col space-y-1 overflow-y-scroll ${boxStyle}`}
            ref={infoRef}
        >

            { messageData.map((message, index) => (
                <div key={index}>
                    { message.has_joined === true && (
                        <div className="flex justify-center text-sm text-green-700">
                            {message.username} has joined the chat.
                        </div>
                    )}

                    { message.has_leaved === true && (
                        <div className="flex justify-center text-sm text-red-600">
                            {message.username} has left the chat.
                        </div>
                    )}

                    { message.is_message === true && (
                        <ChatBubble 
                            isSender={ message.user_id === guestID }
                            name={ message.username }
                            time={ message.created_at }
                            content={ message.content }
                        />
                    )}
                </div>
            ))}

            { sendData.map((sendingMessages, index) => (

                <ChatBubble
                    isSender={ true }
                    isSending= { true }
                    name = { sendingMessages.user_username }
                    content={ sendingMessages.content }
                    key={ index }
                />
            
            ))}

            <div ref={bottomRef} />

        </div>
    )
}