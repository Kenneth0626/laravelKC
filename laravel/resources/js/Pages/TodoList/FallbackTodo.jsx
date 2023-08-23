import TodoHeader from "../Components/TodoHeader";
import EmptyList from "../Components/EmptyTodoList";

export default function Index () {
    
    return (
        <>  
            <TodoHeader isFallback={true}>
                Hello There.
            </TodoHeader>
            
            <EmptyList classStyle="mx-[15rem] mt-24 min-w-[50rem]">
                Nothing to see here...
            </EmptyList>
        </>
    )    
}