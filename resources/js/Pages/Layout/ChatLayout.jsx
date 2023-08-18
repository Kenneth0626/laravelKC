
export default function ChatLayout ({ layoutStyle, children }) {
    return (
        <div className={`border-4 border-black rounded-lg mx-auto my-[5rem] text-xl pt-[1rem] pb-[1rem] bg-slate-300 ${layoutStyle}`}>
            { children }
        </div>
    )
}