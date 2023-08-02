
import { router } from "@inertiajs/react"
import CustomButton from "./CustomButton"

export default function TodoItems (item) {
    
    return (
        <li className="todo-item flex border-4 border-black rounded-lg p-5 bg-slate-300 mb-3">
            <input 
                type="checkbox"
                className="w-10 h-10 rounded-full m-auto align-middle peer/{test}" 
                defaultChecked={item.is_checked === 1}
                onChange={() => router.post(`/${item.id}`, {_method: 'patch', is_checked: item.is_checked === 1 ? 0 : 1, }, { preserveScroll: true })}
            />

            <label className="whitespace-normal text-ellipsis overflow-hidden mx-5 my-auto w-5/6 text-3xl items-center"> 
                {item.title}
            </label>

            <div className="flex space-x-4 items-center m-auto font-bold">
                <CustomButton 
                    buttonStyle="border-green-500 bg-green-200 w-full"
                    onButtonClick={() => router.get(`/edit/${ item.id }`, {page: 2})}
                >
                    EDIT
                </CustomButton>
                
                <CustomButton 
                    buttonStyle="border-red-500 bg-red-200 w-full"
                    onButtonClick={() => router.post(item.id, {_method: 'delete'}, {preserveScroll: true,})}
                >
                    DELETE
                </CustomButton>
            </div>
        </li>            
    )
}