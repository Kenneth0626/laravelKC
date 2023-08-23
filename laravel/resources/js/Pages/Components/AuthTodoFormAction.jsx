
export default function AuthTodoFormAction ({ formActionStyle = "pt-3 justify-end", children }) {
    return (
        <div className={`flex space-x-2 ${formActionStyle}`}>
            {children}
        </div>
    )
}