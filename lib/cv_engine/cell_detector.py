import cv2
from pathlib import Path

print("POCKET MICROSCOPE CV ENGINE")

folder = Path(__file__).parent
image_path = folder / "sample.jpg"

image = cv2.imread(str(image_path))

if image is None:
    print("Image not found!")
else:
    print("Image loaded successfully!")

    # Convert to grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Apply thresholding
    threshold_value = 127
    
    
    # Improve detection under uneven lighting
    gray_blur = cv2.GaussianBlur(gray, (5, 5), 0)

    binary = cv2.adaptiveThreshold(
        gray_blur,
        255,
        cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
        cv2.THRESH_BINARY_INV,
        21,
        5
    )

    # Display both images
    cv2.imshow("Grayscale Image", gray)
    cv2.imshow("Thresholded Image", binary)

    # Step 1: Remove small noise
    kernel = cv2.getStructuringElement(
        cv2.MORPH_ELLIPSE, (3, 3)
    )

    cleaned = cv2.morphologyEx(
        binary, cv2.MORPH_OPEN, kernel, iterations=1
    )

    # Step 2: Find the background
    sure_bg = cv2.dilate(cleaned, kernel, iterations=3)

    # Step 3: Find likely cell interiors
    distance = cv2.distanceTransform(
        cleaned, cv2.DIST_L2, 5
    )

    _, sure_fg = cv2.threshold(
        distance,
        0.6 * distance.max(),
        255,
        cv2.THRESH_BINARY
    )

    sure_fg = sure_fg.astype("uint8")

    # Step 4: Find uncertain areas
    unknown = cv2.subtract(sure_bg, sure_fg)

    # Step 5: Create markers
    _, markers = cv2.connectedComponents(sure_fg)
    markers = markers + 1
    markers[unknown == 255] = 0

    # Step 6: Separate touching regions
    result = image.copy()
    markers = cv2.watershed(result, markers)

    # Step 7: Draw boundaries in green
    result[markers == -1] = (0, 255, 0)

    # Display the results
    cv2.imshow("Original Image", image)
    cv2.imshow("Binary Image", binary)
    cv2.imshow("Likely Cell Interiors", sure_fg)
    cv2.imshow("Watershed Result", result)

    
    print("Watershed processing completed.")

    import numpy as np

    
   
    # Find all candidate regions
    labels = np.unique(markers)
    cell_labels = labels[labels > 1]

    # Measure the area of each region in pixels
    region_areas = []

    for label in cell_labels:
        area = np.count_nonzero(markers == label)
        region_areas.append(area)

    # Display area statistics
    if region_areas:
        areas = np.array(region_areas)

        print("Candidate regions:", len(cell_labels))
        print("Smallest region:", int(np.min(areas)), "pixels")
        print("Median region area:", int(np.median(areas)), "pixels")
        print("Largest region:", int(np.max(areas)), "pixels")
        print("25th percentile:", int(np.percentile(areas, 25)), "pixels")
        print("75th percentile:", int(np.percentile(areas, 75)), "pixels")
    else:
        print("No candidate regions detected.")

    print("Boundary pixels:", np.count_nonzero(markers == -1))

    cv2.waitKey(0)
    cv2.destroyAllWindows()

    
    