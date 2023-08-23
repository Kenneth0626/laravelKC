import CustomButton from "./CustomButton";

export default function TodoForm ({ data, error, handleSubmit, returnLabel, onInput, onReturnButton, formLabel, saveLabel }) {

    return (
        <>
            <CustomButton
                buttonStyle="mx-[15rem] border-red-500 bg-red-200 mt-10 text-xl font-bold"
                onButtonClick={onReturnButton}
            >
                {returnLabel}
            </CustomButton>
            
            <form
                className="mt-2 mx-[15rem] min-w-[50rem] bg-slate-400 border-4 border-black rounded-lg p-10 flex flex-col space-y-4"
                onSubmit={handleSubmit}
            >
                
                <label className="text-3xl font-bold">
                    {formLabel}
                </label>

                {error && <span className="text-red-600 text-xl"> {error} </span>}

                <input
                    type="text"
                    className="rounded-lg text-2xl"
                    value={data.title}
                    placeholder="Title..."
                    onChange={onInput}
                />
    
                <CustomButton buttonStyle="border-green-500 bg-green-200 align-middle mx-auto px-[10rem] text-xl font-bold">
                    {saveLabel}
                </CustomButton>

            </form>
        </>
    )
}