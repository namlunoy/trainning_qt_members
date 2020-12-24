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

function getRoleFromIndex(index) {
    switch(index) {
    case 0:
        return "BA"
    case 1:
        return "Tester"
    case 2:
        return "Developer"
    case 3:
        return "Team Leader"
    default:
        return ""
    }
}

function getColorFromIndex(index) {
    switch(index) {
    case 0:
        return "red"
    case 1:
        return "green"
    case 2:
        return "blue"
    case 3:
        return "yellow"
    default:
        return ""
    }
}
