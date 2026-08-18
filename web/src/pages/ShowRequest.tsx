import { NavLink, useParams } from "react-router";

function ShowRequest() {
    const { reqId: requestId } = useParams<{ reqId: string }>();

    return (
        <div>
            <h1 className="mb-4 text-2xl font-bold">
                Show Request {requestId}
            </h1>
            <NavLink
                to="/"
                className="rounded bg-blue-500 px-4 py-2 text-white hover:bg-blue-600"
            >
                Back to List
            </NavLink>
        </div>
    );
}

export default ShowRequest;
