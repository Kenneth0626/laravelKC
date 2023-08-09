import AuthTodoHeader from '../Components/AuthTodoHeader'
import AuthTodoLayout from '../Layout/AuthTodoLayout'
import { Link } from '@inertiajs/react'

export default function HomeTodo ({ username, todo }) {
    return (
        <AuthTodoLayout layoutStyle="min-w-[80rem] max-w-[80rem]">
            
            <AuthTodoHeader>

                    <h1 className="text-4xl text-ellipsis overflow-hidden">
                        Welcome { username }!
                    </h1>

                    <div className="flex space-x-20 mt-auto">

                        <Link 
                            href='/todo'
                            className="text-blue-800"    
                        >
                            My Todos
                        </Link>

                        <Link 
                            href='/profile'
                            className="text-green-700"    
                        >
                            Edit Profile
                        </Link>

                        <Link
                            href='/logout'
                            method='post'
                            as='button' 
                            className="text-red-600 underline"
                        >
                            Logout
                        </Link>

                    </div>

            </AuthTodoHeader>

                <div className="mt-[1rem] space-y-3">

                    <h1 className="text-3xl">
                        Statistics
                    </h1>

                    <div className="mt=[1rem] text-2xl">

                        <h1>
                            Todos: <span className="text-green-400"> {todo.count} </span> 
                        </h1>

                        <h1>
                            Unfinished Todos: <span className="text-red-600"> {todo.unfinished_count} </span>
                        </h1>

                        <h1>
                            Finished Todos: <span className="text-green-400"> {todo.finished_count} </span>
                        </h1>

                        {/* <h1>
                            Last Finished Todo: <span className="text-green-400"> {todo.last_finished_title || 'None'} </span>
                        </h1> */}
                        
                    </div>

                </div>

        </AuthTodoLayout>
    )
}