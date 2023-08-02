
import { router } from "@inertiajs/react";
import TodoHeader from "../Components/TodoHeader";
import TodoListItems from "../Components/TodoListItems";

export default function Index ({ pages }) {
    
    return (
        <>  
            <TodoHeader>
                Todo List
            </TodoHeader>
            
            <TodoListItems
                page={pages.data}
                pageLink={(pages.links)}
                onAddButton={() => router.get('/create')}
            />
        </>
    )    
}