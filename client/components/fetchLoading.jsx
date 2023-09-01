
export default function FetchLoading ({ textStyle = "text-cyan-600 text-4xl" }) {
    return (
        <h1 className={`text-center italic ${textStyle}`}>
            loading...
        </h1>
    )
}