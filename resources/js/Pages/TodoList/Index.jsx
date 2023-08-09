import { router, Link } from "@inertiajs/react";
import TodoHeader from "../Components/TodoHeader";
import TodoListItems from "../Components/TodoListItems";

export default function Index ({ pages }) {
    
    // Get current active page number
    const currentPage = (pages.links[0].url === null) ? 1 : parseInt(pages.links[0].url.split("=")[1]) + 1

    return (
        <>  
            <TodoHeader>
                Todo List
            </TodoHeader>
            
            <TodoListItems
                page={pages.data}
                currentPage={currentPage}
                pageLink={(pages.links)}
                onAddButton={() => router.get('/todo/create', {page: currentPage})}
            />
        </>
    )    
}