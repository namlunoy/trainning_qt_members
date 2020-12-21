function getColorFromRole(role) {
    switch(role) {
    case "BA":
        return "red"
    case "Tester":
        return "green"
    case "Developer":
        return "blue"
    case "Team Leader":
        return "yellow"
    default:
        return ""
    }
}

function getIndexFromRole(role) {
    switch(role) {
    case "BA":
        return 0
    case "Tester":
        return 1
    case "Developer":
        return 2
    case "Team Leader":
        return 3
    default:
        return -1
    }
}
