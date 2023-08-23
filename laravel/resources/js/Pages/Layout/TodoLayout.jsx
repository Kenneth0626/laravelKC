
export default function TodoLayout ({ layoutStyle, children }) {
    return (
        <div className={`border-4 border-black bg-slate-400 rounded-lg mx-auto my-[5rem] text-xl pt-[1rem] px-5 pb-[1rem] ${layoutStyle}`} >
            {children}
        </div>
    )
}