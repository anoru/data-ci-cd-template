package computerdatabase

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class PredictionSimulation extends Simulation {
  val pause_in_seconds = 1
  val duration_in_minutes = 1
  val max_duration_in_minutes = 3
  val user = 3
  val max_user = 50
  val url_with_port = System.getProperty("url_with_port")
  val httpProtocol = http
    .baseUrl(url_with_port)

  val scn = scenario("PredictionSimulation")
    .exec(http("prediction_200")
      .post("/invocations")
      .body(RawFileBody("deployment/performance_tests/PredictionRequest.json")).asJson
    ).pause(pause_in_seconds)

  setUp(
  scn.inject(rampUsersPerSec(user) to (max_user) during(duration_in_minutes minutes))
  ).maxDuration(max_duration_in_minutes minutes)
   .protocols(httpProtocol)
}
