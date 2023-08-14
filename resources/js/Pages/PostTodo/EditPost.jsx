import { router, useForm } from '@inertiajs/react'
import FormInput from '../Components/FormInput'
import AuthTodoForm from '../Components/AuthTodoForm'
import AuthTodoFormAction from '../Components/AuthTodoFormAction'
import CustomButton from '../Components/CustomButton'

export default function EditPost ({ postData, errors }) {

    const { data, setData, post, processing } = useForm({
        _method: 'patch',
        title: postData.title,
        content: postData.content,
    })

    function handleSubmit(e){
        e.preventDefault()
        post(`/post/${postData.id}/edit`)
    }

    return (
        <>
            <div className="border-4 border-black bg-slate-400 rounded-lg mx-auto my-[5rem] 
                text-xl pt-[1rem] px-5 pb-[1rem] min-w-[80rem] max-w-[80rem]" >
                
                <div className="flex justify-between mb-[1rem]">
                    
                    <h1 className="text-5xl text-ellipsis overflow-hidden">
                        Edit Post
                    </h1>

                </div>
                
                <hr className="border-t-4 border-black rounded-full" />

                <AuthTodoForm 
                    onSubmitButton={handleSubmit}
                    formStyle="text-3xl flex-col"
                >

                    <FormInput
                        useTextArea={true}
                        inputStyle="text-2xl"
                        label="Title"
                        value={data.title}
                        onInputChange={e => setData('title', e.target.value)}
                        inputError={errors.title}
                        errorStyle="text-xl"
                        placeholder="new title..."
                    />

                    <FormInput
                        useTextArea={true}
                        inputStyle="text-2xl"
                        label="Content"
                        value={data.content}
                        onInputChange={e => setData('content', e.target.value)}
                        inputError={errors.content}
                        errorStyle="text-xl"
                        placeholder="new content..."
                    />

                    <AuthTodoFormAction>

                        <CustomButton
                            buttonStyle="border-green-500 bg-green-200"
                            isProcessing={processing}
                        >
                            Save
                        </CustomButton>

                        <CustomButton
                            inputType="button"
                            buttonStyle="border-red-500 bg-red-200"
                            onButtonClick={() => router.get(`/post/${postData.id}`)}
                            isProcessing={processing}
                        >
                            Cancel
                        </CustomButton>

                    </AuthTodoFormAction>

                </AuthTodoForm>

            </div>
        </>
    )
}