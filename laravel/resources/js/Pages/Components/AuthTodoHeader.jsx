
export default function AuthTodoHeader ({ children }) {
    return (
        <>
            <div className="flex justify-between mb-[1rem]">
                {children}
            </div>
            <hr className="border-t-4 border-black rounded-full" />
        </>
    )
}