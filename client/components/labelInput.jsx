
export default function LabelInput ({ useTextArea = false, maxLength = 255, wrapStyle = "space-y-2", errorStyle = "text-sm",
    label, type, value, onChange, placeholder, labelStyle, inputStyle, errors }) {

    return (
        <div className={`flex flex-col ${wrapStyle}`}>

            <label className={`${labelStyle}`}>
                { label }
            </label>

            { errors !== null && (
                <span className={`text-red-600 ${errorStyle}`}>
                    { errors }
                </span>
            )}

            { useTextArea === true ? 
                (
                    <textarea 
                        type={ type }
                        maxLength={ maxLength }
                        value={ value }
                        onChange={ onChange }
                        placeholder={ placeholder }
                        className={`p-2 rounded-lg border-2 ${inputStyle}`}
                    />
                ):
                (
                    <input 
                        type={ type }
                        maxLength={ maxLength }
                        value={ value }
                        onChange={ onChange }
                        placeholder={ placeholder }
                        className={`p-2 rounded-lg border-2 ${inputStyle}`}
                    />
                )
            }

        </div>
    )
}