import TodoItems from "./TodoItems"
import EmptyTodoList from "./EmptyTodoList"
import Pagination from "./Pagination"
import CustomButton from "./CustomButton"

export default function TodoListItems ({ page, currentPage, pageLink, onAddButton }) {

    return (
        <>  
            <CustomButton
                buttonStyle = "border-green-500 bg-green-200 mx-[15rem] mt-10 font-bold text-xl"
                onButtonClick = {onAddButton}
            >
                Add Todo...
            </CustomButton>

            <ul className="mx-[15rem] mt-3 min-w-[50rem]">

                {page.length === 0 && (
                    <EmptyTodoList>
                        Empty
                    </EmptyTodoList>
                )}

                {page.length > 0 && (
                    page.map((item) => {
                        return (
                            <TodoItems 
                                item={item}
                                currentPage={currentPage}
                                itemCount={page.length}
                                key={item.id}
                                
                            />
                        )
                    })
                )}

            </ul>

            <Pagination
                links={pageLink}
                paginationStyle="mx-[15rem]"
                currentPage={currentPage}
            /> 
            
        </> 
    )
}