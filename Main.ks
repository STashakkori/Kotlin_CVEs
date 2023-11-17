// $t@$h
import com.github.doyaaaaaken.kotlincsv.dsl.csvReader
import java.io.File

data class CVE(
    val name: String,
    val status: String,
    val description: String,
    val references: String,
    val phase: String,
    val votes: String,
    val comments: String
)

fun main() {
    val cveList = mutableListOf<CVE>()

    val lines = File("cve.csv").readLines()

    // Find the first empty "name" entry and use that as starting point for data
    var actualStartIndex = lines.indexOfFirst { it.startsWith(",") }

    if (actualStartIndex == -1) {
        println("No valid data delimiter found.")
        return
    }

    actualStartIndex++ // Skip the empty line

    val validCsvData = lines.slice(actualStartIndex until lines.size).joinToString("\n")

    val rows = csvReader().readAll(validCsvData)

    for (row in rows) {
        val cve = CVE(
            name = row[0],
            status = row[1],
            description = row[2],
            references = row[3],
            phase = row[4],
            votes = row[5],
            comments = row[6]
        )
        cveList.add(cve)
    }

    var count = 0
    cveList.forEach {
        if (count < 3) {
            println(it)
            count++
        }
    }
}
