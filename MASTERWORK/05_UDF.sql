--Scalar UDF transform number to Geography datatype

USE [Borderless];
GO

CREATE OR ALTER FUNCTION Aid.TransformGeoPoint(
	@Latitude FLOAT,
	@Longitude FLOAT
)
RETURNS GEOGRAPHY
AS
BEGIN
	DECLARE @Geolocation GEOGRAPHY;
	BEGIN
	SELECT @Geolocation=GEOGRAPHY::Point(@Latitude, @Longitude , 4326)
	END
	RETURN @Geolocation;
END
GO

