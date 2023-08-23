
export default function EmptyTodoList({ classStyle, children }){
    
    return (
        <h1 className={`bg-red-300 border-4 border-red-600 rounded-lg text-center p-4 text-3xl font-bold ${classStyle}`}>
            { children }
        </h1>
    )
}