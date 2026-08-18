import { NavLink } from "react-router";

function ListRequests() {
    return (
        <div>
            <h1 className="mb-4 text-2xl font-bold">List Requests</h1>
            <NavLink
                to="/requests/1"
                className="rounded bg-blue-500 px-4 py-2 text-white hover:bg-blue-600"
            >
                Go to Request
            </NavLink>
        </div>
    );
}

export default ListRequests;
