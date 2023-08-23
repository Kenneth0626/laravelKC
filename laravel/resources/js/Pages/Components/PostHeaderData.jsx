
export default function PostHeaderData ({ author, date, isEdited }) {
    return (
        <div className="flex flex-col space-y-2 whitespace-normal">

            <h2 className="text-2xl">
                by: {author}
            </h2>

            <h3 className="italic text-base">

                posted on {date}

                { isEdited === true && <span> (edited) </span> }
                
            </h3>

        </div>
    )
} 