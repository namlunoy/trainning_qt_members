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

function getIndexFromColor(color) {
    switch(color) {
    case "red":
        return 0
    case "green":
        return 1
    case "blue":
        return 2
    case "yellow":
        return 3
    default:
        return -1
    }
}
