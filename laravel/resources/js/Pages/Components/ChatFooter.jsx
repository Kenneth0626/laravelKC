
export default function ChatFooter ({ onSend, value, onInputChange, usersTyping }) {
    return (
        <div className="mx-5">

            <form 
                className="mb-0 flex space-x-2 text-base"
                onSubmit={ onSend }    
            >

                <input 
                    className="w-full rounded-3xl"
                    type="text"
                    value={ value }
                    onChange={ onInputChange }
                />

                <button 
                    className="py-2 px-4 border-2 border-green-500 bg-green-200 rounded-3xl"
                >
                    send
                </button>

            </form>

            <div className="text-sm text-gray-700 italic">
                { usersTyping.length === 1 && <span> {usersTyping} is typing... </span> }
                { (usersTyping.length > 1 && usersTyping.length < 4) &&  <span> { usersTyping.join(", ")} are typing... </span>}
                { usersTyping.length > 3 && <span> Several people are typing... </span>}
            </div>

        </div>
    )
}